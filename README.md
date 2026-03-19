## FretaGo

FretaGo é um marketplace web-first para fretes locais focado em pessoas que compraram móveis, eletrodomésticos ou outros itens em plataformas como OLX ou Facebook Marketplace e precisam de um motorista para fazer o transporte. A primeira região de operação é Itajaí, Santa Catarina, Brasil.

### Objetivo de negócio

- **Conectar rapidamente clientes que precisam de frete com motoristas locais**, de forma simples, mobile-first e segura.
- Permitir que clientes criem pedidos de frete, motoristas enviem propostas e o cliente aceite a melhor opção.

---

### Tecnologias

- **Backend**: Ruby on Rails 7.2, PostgreSQL
- **Frontend**: TailwindCSS (mobile-first), Hotwire (Turbo) / Stimulus
- **Outros**: RSpec para testes automatizados, esbuild para bundling JS

---

### Requisitos

- Ruby (3.2.x recomendado)
- PostgreSQL
- Node.js + Yarn (para esbuild/Tailwind)

---

### Setup do projeto

1. **Instalar dependências Ruby**

```bash
bundle install
```

2. **Configurar banco de dados**

Atualize `config/database.yml` se necessário (usuário/senha/host do PostgreSQL) e depois:

```bash
bin/rails db:prepare
```

Isso cria e migra os bancos `development` e `test`.

3. **Rodar seeds para dados de demonstração**

```bash
bin/rails db:seed
```

Serão criados:
- 5 motoristas ativos
- 10 pedidos de frete abertos
- algumas propostas associadas

4. **Rodar o servidor de desenvolvimento**

```bash
bin/dev
```

Aplicação disponível em `http://localhost:3000`.

---

### Como rodar os testes

Os testes usam RSpec:

```bash
bundle exec rspec
```

Estão cobertos:
- Validações e associações de `Pedido`, `Motorista` e `Proposta`
- Fluxos HTTP principais (criar pedido, motorista, proposta, aceitar proposta)
- Endpoints JSON da API v1

---

### Principais rotas web (HTML)

- **Home / Landing page**
  - `GET /` → `HomeController#index`

- **Pedidos (clientes e motoristas)**
  - `GET /pedidos` → lista apenas pedidos com status `aberto` (visão para motoristas)
  - `GET /pedidos/new` → formulário de criação de pedido
  - `POST /pedidos` → cria um pedido com status `aberto`
  - `GET /pedidos/:id` → detalhes do pedido, envio de propostas e listagem de propostas
  - `PATCH /pedidos/:id/aceitar_proposta?proposta_id=:proposta_id`
    - cliente aceita uma proposta:
      - proposta selecionada → `aceita`
      - demais propostas do pedido → `recusada`
      - pedido → `aceito`

- **Motoristas**
  - `GET /motoristas/new` → formulário de cadastro de motorista
  - `POST /motoristas` → cria motorista com `ativo = true`

- **Propostas (via interface web)**
  - `GET /pedidos/:pedido_id/propostas/new` → (opcional, UI) nova proposta
  - `POST /pedidos/:pedido_id/propostas` → cria proposta com status `enviada`

---

### API JSON v1 (para uso em Postman)

Namespace base: `/api/v1`

#### 1) Pedidos

- **Listar pedidos**

  - `GET /api/v1/pedidos`
  - Resposta (exemplo):

  ```json
  [
    {
      "id": 1,
      "nome_cliente": "Cliente 1",
      "endereco_retirada": "Bairro Centro, Itajaí",
      "endereco_entrega": "Bairro Fazenda, Itajaí",
      "item": "Sofá de 3 lugares",
      "status": "aberto",
      "created_at": "2026-03-16T22:10:00Z"
    }
  ]
  ```

- **Mostrar um pedido**

  - `GET /api/v1/pedidos/:id`
  - Inclui propostas associadas (sem expor telefone do cliente).

  ```json
  {
    "id": 1,
    "nome_cliente": "Cliente 1",
    "telefone": "47990000000",
    "endereco_retirada": "Bairro Centro, Itajaí",
    "endereco_entrega": "Bairro Fazenda, Itajaí",
    "item": "Sofá de 3 lugares",
    "status": "aberto",
    "propostas": [
      {
        "id": 5,
        "valor": "150.0",
        "status": "enviada",
        "motorista_id": 2
      }
    ]
  }
  ```

- **Criar pedido**

  - `POST /api/v1/pedidos`
  - Body (JSON):

  ```json
  {
    "pedido": {
      "nome_cliente": "João da Silva",
      "telefone": "47999999999",
      "endereco_retirada": "Bairro Centro, Itajaí",
      "endereco_entrega": "Bairro Fazenda, Itajaí",
      "item": "Geladeira",
      "detalhes": "Geladeira em bom estado, precisa subir 2 andares."
    }
  }
  ```

  - Respostas:
    - **201 Created** com JSON do pedido (status `aberto`).
    - **422 Unprocessable Entity** com:

    ```json
    { "errors": ["Nome cliente não pode ficar em branco", "..."] }
    ```

#### 2) Motoristas

- **Listar motoristas ativos**

  - `GET /api/v1/motoristas`

- **Mostrar motorista**

  - `GET /api/v1/motoristas/:id`

- **Criar motorista**

  - `POST /api/v1/motoristas`
  - Body:

  ```json
  {
    "motorista": {
      "nome": "Carlos Souza",
      "telefone": "47988887777",
      "veiculo": "Caminhonete",
      "bairro": "Centro"
    }
  }
  ```

  - Respostas:
    - **201 Created** com JSON do motorista
    - **422 Unprocessable Entity** com `{ "errors": [...] }`

#### 3) Propostas

- **Listar propostas**

  - `GET /api/v1/propostas`

- **Mostrar proposta**

  - `GET /api/v1/propostas/:id`

- **Criar proposta para um pedido**

  - `POST /api/v1/pedidos/:pedido_id/propostas`
  - Body:

  ```json
  {
    "proposta": {
      "motorista_id": 1,
      "valor": 150.0,
      "mensagem": "Consigo buscar hoje à tarde."
    }
  }
  ```

  - Respostas:
    - **201 Created** com JSON `{ "id", "pedido_id", "motorista_id", "valor", "status", "mensagem" }`
    - **422 Unprocessable Entity** com `{ "errors": [...] }`

#### 4) Aceitar proposta (API)

- **Aceitar uma proposta**

  - `PATCH /api/v1/propostas/:id/aceitar`
  - Sem body obrigatório.
  - Comportamento:
    - proposta selecionada → `aceita`
    - demais propostas do mesmo pedido → `recusada`
    - pedido → `aceito`
  - Resposta (sucesso):

  ```json
  {
    "pedido": { "id": 1, "status": "aceito" },
    "proposta": { "id": 5, "status": "aceita" }
  }
  ```

---

### Segurança e privacidade

- **Defaults do Rails**: CSRF habilitado na camada HTML, parâmetros fortes utilizados em todos os controllers.
- **Minimização de dados**:
  - Listagens públicas de pedidos (`/pedidos` e `GET /api/v1/pedidos`) mostram apenas o necessário para decisão do motorista (origem, destino, item, status).
  - Telefone do cliente não é exposto em listagens públicas.
- **Validações fortes** em `Pedido`, `Motorista` e `Proposta` com constraints também em nível de banco.
- **Preparado para LGPD**:
  - Estrutura de controllers e rotas pronta para receber autenticação/autorização futura (ex.: clientes vs motoristas vs admin).
  - Fácil extensão para adicionar:
    - autenticação (`has_secure_password` ou Devise),
    - autorização (Pundit/CanCanCan),
    - painel administrativo,
    - notificações por WhatsApp,
    - suporte PWA avançado.

---

### Próximos passos sugeridos

- Implementar autenticação básica para diferenciar fluxos de cliente e motorista.
- Adicionar um painel simples de administração (por exemplo, via gem administrate ou Rails Admin).
- Integrar envio de notificações via WhatsApp (ex.: através de um provider externo) quando propostas forem criadas ou aceitas.
- Evoluir o layout mobile-first para um design ainda mais refinado e adicionar instalação como PWA para uso em tela cheia no celular.


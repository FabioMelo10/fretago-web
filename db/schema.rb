# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_03_16_221922) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "motoristas", force: :cascade do |t|
    t.string "nome", null: false
    t.string "telefone", null: false
    t.string "veiculo", null: false
    t.string "bairro", null: false
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.string "nome_cliente", null: false
    t.string "telefone", null: false
    t.string "endereco_retirada", null: false
    t.string "endereco_entrega", null: false
    t.string "item", null: false
    t.text "detalhes"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "propostas", force: :cascade do |t|
    t.bigint "pedido_id", null: false
    t.bigint "motorista_id", null: false
    t.decimal "valor", precision: 10, scale: 2, null: false
    t.text "mensagem"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["motorista_id"], name: "index_propostas_on_motorista_id"
    t.index ["pedido_id", "motorista_id"], name: "index_propostas_on_pedido_id_and_motorista_id"
    t.index ["pedido_id"], name: "index_propostas_on_pedido_id"
  end

  add_foreign_key "propostas", "motoristas"
  add_foreign_key "propostas", "pedidos"
end

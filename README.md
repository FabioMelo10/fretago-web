🚚 FretaGo

FretaGo is a regional MVP marketplace designed to connect customers with nearby drivers for small and fast freight deliveries.

It focuses on solving real-world logistics needs such as:

Furniture transport
Appliance delivery
Store pickups
OLX and Facebook Marketplace deliveries

Built with Ruby on Rails, the project aims to validate a scalable logistics solution starting from local demand.

📍 Coverage Area

FretaGo currently operates in:

Itajaí
Navegantes
Balneário Camboriú
Camboriú
Nearby cities

The platform is designed to expand regionally over time.

⚡ Current MVP Focus

The current version is focused on validation and real usage, not full automation.

Main flow:

User submits a freight request (no login required)
Request is stored and processed
Customer is redirected to WhatsApp for fast negotiation
Driver is matched manually
Freight is completed

👉 The goal is speed, simplicity, and real-world execution

🧩 Features
✅ Implemented (MVP)
Freight request creation (origin, destination, item)
No-login flow for fast conversion
Regional positioning (local drivers)
Success page with WhatsApp integration
Pre-filled WhatsApp message for faster contact
Simple request management (Rails backend)
Responsive UI using TailwindCSS
🚀 Future Improvements

Planned next steps based on real usage:

Driver matching optimization
Request status tracking (negotiating, completed, canceled)
Pricing support and suggestions
Admin dashboard improvements
Driver onboarding flow
Regional expansion
🛠 Tech Stack
Ruby 3.x
Ruby on Rails 7.x
PostgreSQL
TailwindCSS
Hotwire / Stimulus
▶️ Running Locally

# Install dependencies

bundle install

# Setup database

bin/rails db:prepare
bin/rails db:seed

# Run the app

bin/dev

Then open:

👉 http://localhost:3000

🔐 Environment Variables

Configure your WhatsApp number:

FRETAGO_WHATSAPP_NUMBER=5547999999999
📌 Project Status

This project is:

An MVP under validation
Focused on real-world usage
Continuously evolving based on feedback
⚠️ Disclaimer

This is a portfolio and experimental project created for learning, validation, and demonstration purposes.

It is not intended for production use at scale (yet).

📄 License

This project is for educational and portfolio use.

👨‍💻 Author

Fábio Lucas de Melo

GitHub: https://github.com/FabioMelo10
LinkedIn: https://www.linkedin.com/in/fabio-lucas-de-melo/
💥 Final Note

FretaGo is not just a project — it's a real attempt to build a business from scratch, starting with a simple idea:

Connect people who need fast delivery with drivers who are already nearby.

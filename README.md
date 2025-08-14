# Rails Cash Register (Prototype)

## Overview
This is a prototype cash register application built with Ruby on Rails **without JavaScript**. It demonstrates basic CRUD operations for products, basket management, and real-time price calculations with discount rules.

**Features:**
- **Admin Products page**: Add/edit products, set discount rules.
- **User Baskets page**: Create baskets, add/remove products, view totals.
- **Discount rules**:
  - **Buy-One-Get-One (BOGO)**
  - **Bulk discount**: Price reduction when a quantity threshold is reached.
- Currency-safe price handling using the [`money`](https://github.com/RubyMoney/money) gem.
- RSpec unit and request tests.
- Seed data with example products.

---

## Setup

### 1. Clone and Install Gems
```bash
git clone <repo-url>
cd till
bundle install
```

### 2. Database Setup
```bash
bin/rails db:create db:migrate db:seed
```

**Seeded products:**
- **GR1** — Green Tea (€3.11, BOGO)
- **SR1** — Strawberry (€5.00, bulk discount: 4+ items → 60% off each)
- **CF1** — Coffee (€11.23, no discount)

### 3. Run the Server
```bash
bin/rails s
```

Visit:
- **Baskets (user-facing)**: [http://localhost:3000](http://localhost:3000)
- **Products (admin)**: [http://localhost:3000/products](http://localhost:3000/products)

---

## Usage

### Products Page
- Add new products.
- Edit existing products.
- Set `discount_rule`, `discount_threshold`, and `discount_percentage` where applicable.

### Baskets Page
- Create a basket via **Add Basket**.
- Add products from a dropdown.
- Remove products.
- View computed total price (discounts applied automatically).

---

## Discount Rules

### 1. Buy-One-Get-One (BOGO)
- Every second item of the same product is free.
- Example: 3 × GR1 → pay for 2.

### 2. Bulk Discount
- If `count >= discount_threshold`, each unit gets a price reduction of `discount_percentage`.
- Example: SR1, €5.00, threshold 4, 60% off → 5 × SR1 → €0.80 each.

---

## Running Tests
```bash
bin/rspec
```

**Test coverage includes:**
- **Service specs** for `PriceCalculator`.
- **Request specs** for basket workflows.

---

## Technical Notes
- No JavaScript; all deletes use `button_to` (server-side DELETE forms).
- Prices stored as decimals in DB; converted to cents for computation.
- `BasketItem.price` is a snapshot; totals are recomputed using current product prices + rules.

---

## Screenshot

![Cash Register Screenshot](https://i.imgur.com/0eoxVjC.png)

## License
MIT — free to use and modify.

-- ============================================================
-- BlackOut Pub — Menu Generale (Cibo & Drink)
-- Esegui questo script nell'SQL Editor di Supabase
-- ============================================================

-- Tabella menu_generale
CREATE TABLE IF NOT EXISTS menu_generale (
  id              BIGSERIAL    PRIMARY KEY,
  name            TEXT         NOT NULL,
  description     TEXT,
  price           NUMERIC(6,2) NOT NULL,
  macro_category  TEXT         NOT NULL CHECK (macro_category IN ('Cucina', 'Drink')),
  sub_category    TEXT         NOT NULL,
  -- esempi: 'Hamburger', 'Fuori Menu', 'Piadine', 'Cocktail', 'Gin', 'Vini', 'Birre Artigianali', ...
  available       BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Indici utili per le query più comuni
CREATE INDEX IF NOT EXISTS idx_menu_macro ON menu_generale (macro_category);
CREATE INDEX IF NOT EXISTS idx_menu_sub   ON menu_generale (sub_category);
CREATE INDEX IF NOT EXISTS idx_menu_avail ON menu_generale (available);

-- ── Row Level Security ──────────────────────────────────────

ALTER TABLE menu_generale ENABLE ROW LEVEL SECURITY;

-- Chiunque (utente cliente) può leggere
CREATE POLICY "Lettura pubblica menu_generale"
  ON menu_generale FOR SELECT USING (true);

-- Solo il service_role (il server Node.js) può scrivere
CREATE POLICY "Scrittura server menu_generale"
  ON menu_generale FOR ALL USING (auth.role() = 'service_role');

-- ── Dati di esempio ─────────────────────────────────────────
-- Rimuovi o commenta questa sezione se vuoi partire da zero

INSERT INTO menu_generale (name, description, price, macro_category, sub_category, available) VALUES
  -- Cucina — Hamburger
  ('BlackOut Burger',       'Doppio manzo, cheddar, bacon croccante, cipolla caramellata, salsa BBQ',   12.00, 'Cucina', 'Hamburger',   true),
  ('Veggie Burger',         'Burger di ceci, avocado, insalata mista, pomodoro, maionese vegan',        10.50, 'Cucina', 'Hamburger',   true),
  ('Chicken Smash',         'Pollo smashato, jalapeños, cheddar fuso, lattuga, salsa ranch',            11.00, 'Cucina', 'Hamburger',   true),

  -- Cucina — Fuori Menu
  ('Piadina Prosciutto',    'Prosciutto cotto, stracchino, rucola fresca',                               7.50, 'Cucina', 'Fuori Menu',  true),
  ('Piadina Salame',        'Salame Milano, squacquerone, pomodorini',                                   7.00, 'Cucina', 'Fuori Menu',  true),
  ('Tagliere Salumi',       'Selezione di salumi locali con pane fatto in casa',                         9.00, 'Cucina', 'Fuori Menu',  true),
  ('Patatine Fritte',       'Patatine dorate con sale e rosmarino',                                      4.50, 'Cucina', 'Fuori Menu',  true),

  -- Drink — Cocktail
  ('Spritz Aperol',         'Aperol, Prosecco, soda, scorza d''arancia',                                 6.00, 'Drink',  'Cocktail',    true),
  ('Negroni',               'Gin, Campari, Vermouth rosso',                                              7.00, 'Drink',  'Cocktail',    true),
  ('Moscow Mule',           'Vodka, ginger beer, lime, menta',                                           7.50, 'Drink',  'Cocktail',    true),
  ('Hugo',                  'Prosecco, sambuco, soda, menta fresca',                                     6.00, 'Drink',  'Cocktail',    true),

  -- Drink — Gin
  ('Hendrick''s & Tonic',   'Hendrick''s Gin, tonica premium, cetriolo',                                 9.00, 'Drink',  'Gin',         true),
  ('Monkey 47',             'Monkey 47 Gin, tonica Fever-Tree, scorza di limone',                       11.00, 'Drink',  'Gin',         true),
  ('Tanqueray Ten',         'Tanqueray No. Ten, tonica, pompelmo rosa',                                   8.50, 'Drink',  'Gin',         true),

  -- Drink — Vini
  ('Sangiovese IGT',        'Rosso toscano, corposo e fruttato — calice',                                5.50, 'Drink',  'Vini',        true),
  ('Pinot Grigio',          'Bianco fresco delle Venezie — calice',                                       5.00, 'Drink',  'Vini',        true),
  ('Prosecco DOC',          'Bollicine del Veneto — flûte',                                               5.00, 'Drink',  'Vini',        true);

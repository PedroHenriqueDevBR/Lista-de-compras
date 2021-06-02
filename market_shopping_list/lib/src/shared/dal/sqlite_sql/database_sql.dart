class DatabaseSQL {
  static final FAMILY = 'family';
  static final SHOPPING_LIST = 'shopping_list';
  static final PURCHASE_ITEM = 'purchase_item';

  static final DATABASE_CREATOR_SQL = """
  CREATE TABLE `${FAMILY}` (
    `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
    `name`	TEXT NOT NULL
  );

  CREATE TABLE `${SHOPPING_LIST}` (
    `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
    `title`	TEXT,
    `description`	TEXT,
    `is_done`	INTEGER DEFAULT 0,
    `create_at`	TEXT,
    `family`	INTEGER,
    FOREIGN KEY(`${FAMILY}`) REFERENCES `${FAMILY}`(`id`)
  );

  CREATE TABLE `${PURCHASE_ITEM}` (
    `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
    `product_name`	TEXT NOT NULL,
    `quantity`	INTEGER NOT NULL,
    `price`	REAL NOT NULL,
    `shopping_list`	INTEGER,
    FOREIGN KEY(`${SHOPPING_LIST}`) REFERENCES `${SHOPPING_LIST}`(`id`)
  );
  """;
}

# README

## users テーブル

| column             | Type    | Options                       |
| ------------------ | ------- | ----------------------------- |
| email              | string  | null: false, uniqueness: true |
| nickname           | string  | null: false                   |
| encrypted_password | string  | null: false                   |
| family_name        | string  | null: false                   |
| first_name         | string  | null: false                   |
| family_name_kana   | string  | null: false                   |
| first_name_kana    | string  | null: false                   |
| birthday           | data    | null: false                   |

### Association

- has_many :items
- has_many :buyers

## items テーブル

| column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| item_name             | string      | null: false                    |
| description           | text        | null: false                    |
| category_id           | integer     | null: false                    |
| status_id             | integer     | null: false                    |
| which_delivery_fee_id | integer     | null: false                    |
| prefecture_id         | integer     | null: false                    |
| days_to_delivery_id   | integer     | null: false                    |
| price                 | integer     | null: false                    |
| user                  | references  | null: false, foreign_key: true |

### Association

- has_one :buyer
- belongs_to :user

## shipping_address テーブル

| column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| postal_code        | string      | null: false                    |
| prefecture_id      | integer     | null: false                    |
| municipalities     | string      | null: false                    |
| address            | string      | null: false                    |
| building           | string      |                                |
| tel                | string      | null: false                    |
| buyer_id           | references  | null: false, foreign_key: true |

### Association

- belongs_to :buyer

## buyers テーブル

| column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| user               | references  | null: false, foreign_key: true |
| item               | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address
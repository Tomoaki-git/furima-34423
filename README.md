# README

## users テーブル

| column      | Type    | Options     |
| ----------- | ------- | ----------- |
| email       | string  | null: false |
| nickname    | string  | null: false |
| password    | string  | null: false |
| family_name | string  | null: false |
| first_name  | string  | null: false |
| first_name  | string  | null: false |
| birthday    | data    | null: false |

## items テーブル

| column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| item_name          | string      | null: false |
| description        | text        | null: false |
| category           | data        | null: false |
| status             | data        | null: false |
| which_delivery_fee | data        | null: false |
| shipping_area      | data        | null: false |
| days_to_delivery   | data        | null: false |
| price              | string      | null: false |
| user_id            | references  | null: false |

## buyers テーブル

| column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| postal_code        | string      | null: false |
| prefecture         | data        | null: false |
| municipalities     | string      | null: false |
| address            | string      | null: false |
| building           | string      |             |
| tel                | string      | null: false |
| item_id            | references  | null: false |
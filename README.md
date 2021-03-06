# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|


### Association
- has_one :profile,dependent: :destroy
- has_one :shipping_destination, dependent: :destroy
- has_one :card, dependent: :destroy
- has_many :items, dependent: :destroy

## Profilesテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|user|reference|null: false, foreign_key: true|


### Association
- belongs_to :user


## Items テーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|category|reference|null: false, foreign_key:|
|brand|reference|foreign_key: true|
|item_condition|reference|null: false, foreign_key:|
|postage_payer|reference|null: false, foreign_key: 
|shipping_prefecture|integer|null: false|
|shipping_day|reference|null: false, foreign_key:|
|price|integer|null: false|
|user|reference|null: false, foreign_key:|
 
### Association
- belongs_to :category 
- belongs_to :brand 
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :shipping_day
- belongs_to_active_hash :postage_type
- has_many :item_imgs, dependent: :destroy
- belongs_to :user



## Categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|

### Association
- has_many :items 


## Brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
-has_many :items 

## Item_condition  テーブル

|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|


### Association
- has_many :items

## Item_imgs  テーブル

|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item|reference|null: false, foreign_key: true|

### Association
- belongs_to :item


## Postage_payers テーブル

|Column|Type|Options|
|------|----|-------|
|payer|string|null: false|

### Association
- has_many :items


## Shipping_destinationテーブル

|Column|Type|Options|
|------|-----|-----|
|destination_first_name|string|null:false|
|destination_last_name|string|null:false|
|destination_first_name_kana|string|null:false|
|destination_last_name_kana|string|null:false|
|post_code|integer(7)|null:false|
|prefecture_code|integer|null:false|
|city|string|null:false|
|address|string|null:false|
|building|string||
|phone_number|integer|unique:true|
|user|reference|null: false, foreign_key: true|


### Association
- belongs_to :user

## Shipping_day テーブル

|Column|Type|Options|
|------|----|-------|
|day|string|null: false|

### Association
- has_many :items


## Cards テーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|

### Association
- belongs_to:user

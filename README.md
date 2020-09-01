## DB設計
### addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null:false|
|prefecture|string|null: false|
|city|string|null:false|
|house_number|string|null:false|
|number_sign_etc|string||
|phone_number|integer||
|user_id|integer|null: false, foreign_key|
#### Association
- belongs_to :user

### usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false|
|password|string|null: false, unique: true, minimum: 7|
|family_name_kanji|string|null: false|
|first_name_kanji|string|null:false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday_y_m_d|string|null: false|
#### Association
- has_many :addresses
- has_many :favorites
- has_many :products
- has_many :comments
- has_many :credit_cards

### cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false foreign_key: true|
|payjp_id|string||
#### Association
- belongs_to :user

### favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :product

### productsテーブル
|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false|
|product_explanation|string|null: false|
|brand|string||
|product_status_id|string|null:false|
|shipping_method_id|string|null: false|
|shipping_charge_id|string|null: false|
|shipping_area_id|string|null: false|
|days_until_shipping_id|string|null:false|
|price|integer|null: false|
|status|string|null: false|
|user_id|integer|null:false, foreign_key: true|
#### Association
- belongs_to :user
- has_many :favorites
- belongs_to :category
- has_many :images
- has_many :comments

### imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string||
|product_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :product

### commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :product
- belongs_to :user

### categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
#### Association
- has_many :products

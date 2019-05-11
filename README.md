## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, foreign_key: true|
|role|string|
|sex|boolean|
|money|integer|null: false|
|bio|text|
|uid|string|
|age|integer|
|provider|string|

### Association
- has_many :questions
- has_many :answers


## questions table

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|text|text|null: false|
|done|boolean|
|category_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- has_many :answers
- belongs_to :user
- belongs_to :category
- has_one :pv


## answers table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|best_answer|boolean|
|question_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :question


## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|


### Association
- has_many :questions



## pvs table

|Column|Type|Options|
|------|----|-------|
|pv|integer|null: false|
|question_id|references|null: false, foreign_key: true|


### Association
- belongs_to :question


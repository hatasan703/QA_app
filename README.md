## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, foreign_key: true|
|role|string|
|sex|boolean|
|money|integer|default: 0|
|bio|text|
|uid|string|
|age|integer|
|image|text|
|provider|string|
|admin|boolean|

### Association
- has_many :questions, dependent: :destroy
- has_many :answers, dependent: :destroy
- has_many :impressions, dependent: :destroy
-   has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
- has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
- has_many :articles, dependent: :destroy

## questions table

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|text|text|null: false|
|point|integer|null: false|
|done|boolean|
|impressions_count|integer|default: 0|
|category_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- has_many :answers
- belongs_to :user
- belongs_to :category
- has_many :notifications,dependent: :destroy

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
- has_many :notifications,dependent: :destroy


## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|


### Association
- has_many :questions



## notifications table

|Column|Type|Options|
|------|----|-------|
|visiter_id|integer||
|visited_id|integer||
|question_id|integer||
|answer_id|integer||
|action|string||
|check|boolean|default: false|


### Association
- belongs_to :question, optional: true
- belongs_to :answer, optional: true



## articles table

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|text|text|null: false|
|check|boolean|default: false|
|user_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user

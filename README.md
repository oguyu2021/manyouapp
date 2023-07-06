# README

labelsテーブル

カラム名	   データ型
|name	     |string  |
|created_at|datetime|
|updated_at|datetime|

tasksテーブル

カラム名	     データ型	  制約
|title      |string	
|content    |text	
|user_id	  |bigint	   |NOT NULL
|created_at	|datetime	 |NOT NULL
|updated_at	|datetime	 |NOT NULL

taskslabelsテーブル

カラム名	    データ型	  制約
|task_id	  |bigint	  |NOT NULL
|label_id	  |bigint	  |NOT NULL
|created_at	|datetime	|NOT NULL
|updated_at	|datetime	|NOT NULL

usersテーブル

カラム名	     データ型
|name	      |string
|email	    |string
|created_at	|datetime
|updated_at	|datetime
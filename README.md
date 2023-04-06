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


## Task:
Bug title unique in Project scope (Model Level) - ok
Use enum for user_type (Model Level) - ok
Correct bugs users relation - ok


Custom Validation, for valid bug_status - ok

2 Scopes => 1: Bug.features  2: Bug.bugs - ok
2 Class Methods =>  1: Bug.m_features  2: Bug.m_bugs - ok















#Eval:
Bug
  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

Project
  belongs_to :manager, class_name: 'User', foreign_key: 'user_id'

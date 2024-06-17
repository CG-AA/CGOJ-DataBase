| Table Name            | Primary Key Columns       |
|-----------------------|---------------------------|
| permission_flags      | name                      |
| users                 | id                        |
| roles                 | name                      |
| user_roles            | user_id, role_name        |
| problems              | id                        |
| problem_sample_IO     | id                        |
| tags                  | name                      |
| problem_tags          | problem_id, tag_name      |
| problem_test_cases    | id                        |
| solutions             | id                        |
| hints                 | id                        |
| submissions           | id                        |
| submissions_subtasks  | submission_id, id         |
| problem_role          | problem_id, role_name     |
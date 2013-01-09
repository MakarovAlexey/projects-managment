CREATE TABLE projects (
    id,
    name text,
    master_branch
)

CREATE TABLE task_groups (
    id,
    name text,
    manager
)

CREATE TABLE root_task_groups (
    id,
    project_id
)

CREATE TABLE common_task_groups (
    id
)

CREATE TABLE branches (
    project_id,
    id,
    initial_commit_id,
)

-- изменеия которые будут при определенных условиях (в терминологии VCS, ветка (brach), когда риск "срабатывает" - то изменения из ветки риска попадают в master-верку.

CREATE TABLE commits (
    project_id,
    branch_id,
    id,
    comment
)

CREATE TABLE initial_commits (
    project_id,
    branch_id,
    commit_id
)

CREATE TABLE further_commits (
    project_id,
    branch_id,
    commit_id,
    previous_commit_id,
    comment
)

CREATE TABLE branch_mergings (
    project_id,
    branch_id,
    commit_id,
    branch_from_id,
    commit_from_id,
    comment
)







CREATE TABLE tasks (
    id
)

-- задачи (работы) tasks - это аналитические счета, в их разрезе производится корректировка сроков и ресурсов (ресурсы нескольких видов - контрагент, сортрудник, стоимость, это как-бы субчета аналитических счетов)



CREATE TABLE task_periods;

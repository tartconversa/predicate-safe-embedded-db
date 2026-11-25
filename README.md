# 本地排班数据库的范围事务与断电恢复

各记录目录保存独立的合成业务资料。SQL 文件仅包含原始关系表与已有行。manifest.json 记录库角色、表、行数及运行参数。timeline.json 记录后续客户端行为、来源提交或故障，用 pos 表示可比较的到达次序。同一 pos 按数组顺序。提交位置由相应记录的业务字段指定。

## 接入协议

客户端请求使用 begin、get、range、put、delete、savepoint、rollback_to、commit 和 abort。每个表各自有字符串主键，按 UTF-8 字节序排列，range 左闭右开。教员占用表以对象行字段 slot 为范围查询属性，查询返回主键和实际属性，范围可跨主键不相邻的多行。教员 i、j 的课时不能与自身同时段重叠。调度业务以事务中的查询是否看到已有占用为依据，存储提供可串行化语义。
`wire_id` 为客户重试身份。历史配额的单位为一个值版本的逻辑字节，包含表名、键和 JSON 值的 UTF-8 字节长度之和，初始表也计入。`fault` 是本地驱动可在指定阶段触发的断电情形，其中 durable_before_reply 表示持久完成后未给客户端响应，mid_write 表示持久化过程截断。可使用同义的本地故障注入接口。

## 本地资料

使用 Python 3.11.2 和内置 SQLite 3.40.1。以下命令从记录创建关系库，目标文件需要尚不存在。各角色可以作为独立 SQLite 文件读取。

~~~sh
python3 seed_db.py fixtures/empty-range-and-commit-recovery main-local.db --role main
~~~

使用 Python 的 sqlite3 打开新文件即可访问原始表。用 python3 -m unittest -v 核对资料可装载、表与原始记录一致、SQLite 可同时打开读写连接。后续事件保存在各自的原始记录中。

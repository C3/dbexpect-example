require 'odbc'
@src = ODBC.connect('dbexpect_src','dbexpect','dbexpect')
@tgt = ODBC.connect('dbexpect_tgt','dbexpect','dbexpect')

query = @src.run('select upper(name),id from dbexpect_src.customers_src')

query.to_a.each do |row|
  next if row[0] == 'SMITH'
  @tgt.run("insert into dbexpect_tgt.customers_tgt (name,id) values ('#{row[0]}',#{row[1]})").drop
end

query.drop

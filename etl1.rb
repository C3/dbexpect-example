require 'odbc'
@src = ODBC.connect('testgen_src','testgen','testgen')
@tgt = ODBC.connect('testgen_tgt','testgen','testgen')

query = @src.run('select upper(name),id from testgen_src.customers_src')

query.to_a.each do |row|
  @tgt.run("insert into testgen_tgt.customers_tgt (name,id) values ('#{row[0]}',#{row[1]})").drop
end

query.drop

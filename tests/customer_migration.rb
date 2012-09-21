requires "defaults/customers_defaults.rb"

describe "Moving customers from source to target" do
  @src = table(:testgen_src,:testgen_src,:customers_src)
  @tgt = table(:testgen_tgt,:testgen_tgt,:customers_tgt)

  etl_run_command "ruby etl2.rb"

  expect_total_rows @tgt, 1

  describe "it should upcase customer names" do
    insert_into @src,
      [:id,:name],
      [[1,"Fred"]]

    expect_rows @tgt,
      [:id,:name],
      [[1,"FRED"]]
  end

  describe "it should not migrate smith (because screw that guy)" do
    insert_into @src,
      [:id,:name],
      [[1,"Smith"]]

    # expect no rows
  end
end

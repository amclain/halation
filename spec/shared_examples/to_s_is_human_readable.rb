shared_examples :to_s_is_human_readable do
  specify "to_s is human readable" do
    subject.to_s.should_not include "#<Halation::"
  end
end

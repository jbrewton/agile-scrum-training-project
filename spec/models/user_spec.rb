describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "should return hello world" do
    subject.hello_world.should == "Hello World"
  end

  it "should return hello world" do
    subject.hello_world.should == "Hello World"
  end

end

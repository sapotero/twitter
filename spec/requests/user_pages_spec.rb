require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it "should include the page title" do
      full_title("Sign up").should =~ /Sign up/
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it "should include the page title" do
      full_title(user.name).should match(user.name)
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    
    it "should include the page title" do
      full_title("Sign in").should =~ /Sign in/
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end

    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it "should include the page title" do
        full_title(user.name).should match(user.name)
      end
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end

  end
end
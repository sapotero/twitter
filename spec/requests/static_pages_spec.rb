require 'spec_helper'
include ApplicationHelper

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Twitter') }

    it "should include the base title" do
      full_title("foo").should =~ /^Twitter/
    end 
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    
    it "should include the page title" do
      full_title("Help").should =~ /Help/
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    
    it "should include the page title" do
      full_title("About Us").should =~ /About Us/
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    
    it "should include the page title" do
      full_title("Contact Us").should =~ /Contact Us/
    end

    it "should include the base title" do
      full_title("Twitter").should =~ /^Twitter/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end

   it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'h1', text: 'About Us'
    click_link "Help"
    page.should have_selector 'h1', text: 'Help'
    click_link "Contact"
    page.should have_selector 'h1', text: 'Contact'
    click_link "Twitter"
    page.should have_selector 'h1', text: 'Twitter'
  end

end
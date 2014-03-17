require 'spec_helper'
describe "Static pages" do
    subject {page} 
    describe "Home page" do
        before { visit root_path }
        it { should have_content('BitChange') }
        it { should have_title(full_title('')) } 
        it { should_not have_title(' | Home') } 
    end
    describe "Help page" do
        subject {page}
        before { visit help_path }
        it { should  have_content('Help')  } 
        it { should  have_title(full_title('Help')) } 
    end
    describe "About page" do
        subject {page}
        before { visit about_path }
        it { should  have_content('About')  } 
        it { should  have_title(full_title('About')) } 
    end 

    describe "Contact page" do  
        subject {page}
        before { visit contact_path }
        it { should  have_content('Contact')  } 
        it { should  have_title(full_title('Contact')) }   
    end 
end

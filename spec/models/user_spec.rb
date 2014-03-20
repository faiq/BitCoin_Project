require 'spec_helper'

describe User do

    before  { @user = User.new(name: "Example User", email: "example@user.com", password_confirmation: "fakepw", password: "fakepw") } 

    subject { @user }
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }  
    it { should respond_to(:password) }
    it { should respond_to(:authenticate) }
    it { should be_valid } # a sanity check to see if the user is valid 
   
    describe "with a password that's too short" do
        before { @user.password = @user.password_confirmation = "a" * 5 }
        it { should be_invalid }
    end

    describe "return value of authenticate method" do
        before { @user.save }
        let(:found_user) { User.find_by(email: @user.email) }

        describe "with valid password" do
            it { should eq found_user.authenticate(@user.password) }
        end

        describe "with invalid password" do
            let(:user_for_invalid_password) { found_user.authenticate("invalid") }

            it { should_not eq user_for_invalid_password }
            specify { expect(user_for_invalid_password).to be_false }
        end
    end
   
    describe "when password is not present" do
        before { @user.password = " " , @user.password_confirmation = " " }
        it { should_not be_valid }
    end 

    describe "when passwords do not match" do 
        before { @user.password_confirmation = " " }
        it { should_not be_valid } 
    end

    describe "when username is not present" do
        before { @user.name = " " }
        it { should_not be_valid } 
    end

    describe "when email is not present" do
        before { @user.email = " " }
        it { should_not be_valid } 
    end

    describe "when username is too long" do  # a test to check if a string longer than 16 characters can be valid  
        before { @user.name = "a" * 17 }
        it { should_not be_valid }
    end

    describe "Invalid email addresses" do 
        it "should be invlaid" do
            invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.
                             foo@bar_baz.com foo@bar+baz.com]
                             invalid_emails.each { |x| 
                                 @user.email = x
                                 expect(@user).not_to be_valid
                             }
        end #end it
    end #end do

    describe "Valid email addresses" do 
        it "shoudl be valid " do
            valid_emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            valid_emails.each { |x|
                @user.email = x
                expect(@user).to be_valid
            }
        end
    end

    describe "Non unique email addresses" do
        before do 
            newuser = @user.dup
            newuser.save
        end 
        it { should_not be_valid } 
    end
end

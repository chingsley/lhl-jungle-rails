require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'is created successfully with all required fields correctly specified' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save!
      expect(@user.id).to be_present  
    end

    it 'validates :first_name, presence: true' do
      @user = User.new({
        first_name:  nil,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")  
    end

    it 'validates :last_name, presence: true' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  nil,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")  
    end

    it 'validates :email, presence: true' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: nil,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")  
    end

    it 'validates :email, uniqueness: { case_sensitive: false }' do
      @user1 = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: 'test@gmail.com',
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user2 = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: 'TEST@gmail.com',
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user1.save!
      @user2.save
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")  
    end

    it 'validates :password, presence: true' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: nil,
        password_confirmation: '123*Testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password can't be blank")  
    end

    it 'validates :password_confirmation, presence: true' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: nil
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password confirmation can't be blank")  
    end

    it 'ensures password and password confirmation match' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: 'not-testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")  
    end

    it 'password: length: { minimum: 8 }, :if => :password_changed?' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'Testing', # 7/8 characters
        password_confirmation: 'Testing'
      })
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 8 characters)")  
    end

  end

  describe '.authenticate_with_credentials' do
    it 'returns user if user is authenticated' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: 'test@gmail.com',
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save!
      user = User.authenticate_with_credentials(@user.email, @user.password);
      expect(user.id).to be_present  
    end

    it 'returns nil if user is NOT authenticated' do
      user = User.authenticate_with_credentials('test@gmail.com', '123*Testing');
      expect(user).to be_nil  
      # expect(user).to_not be_nil   # to test failure case
    end

    it 'authenticates user with trailing spaces in email' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save!
      user = User.authenticate_with_credentials(@user.email+"  ", @user.password);
      expect(user.id).to be_present  
    end


    it 'uses case insensitive search by email' do
      @user = User.new({
        first_name:  Faker::Name.first_name,
        last_name:  Faker::Name.last_name,
        email: Faker::Internet.email,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save!
      user = User.authenticate_with_credentials(@user.email.upcase, @user.password);
      expect(user.id).to be_present  
    end

  end
end

require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
  it "is not valid unless it has a unique name" do
    Restaurant.create(name: "The Lady Luck")
    restaurant = Restaurant.new(name: "The Lady Luck")
    expect(restaurant).to have(1).error_on(:name)
  end

  it 'restaurant has many reviews' do 
    should have_many(:reviews)
  end 

  it 'restaurant has many users' do 
    should have_many(:users)
  end 
  
end

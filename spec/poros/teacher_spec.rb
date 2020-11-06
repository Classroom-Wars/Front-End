require 'rails_helper'

describe Teacher do
  before :each do
    @teacher_info = {:data=>
                      {:id=>"2",
                      :type=>"student",
                      :attributes=>
                        {:first_name=>"Boom",
                        :last_name=>"Shakalaka",
                        :provider=>"google_oauth2",
                        :uid=>"1057629160",
                        :email=>"boom@email.com",
                        :token=>"ya29.A0AfH6SMBTJgWLj4lYkXMoFz",
                        :refresh_token=>nil},
                      :relationships=>{:courses=>{:data=>[]}}
                      }
                    }

    @teacher = Teacher.new(@teacher_info)
  end
  it "exists with attributes" do
    expect(@teacher).to be_a(Teacher)
    expect(@teacher.id).to eq(2)
    expect(@teacher.provider).to eq("google_oauth2")
    expect(@teacher.uid).to eq("1057629160")
    expect(@teacher.email).to eq("boom@email.com")
    expect(@teacher.token).to eq("ya29.A0AfH6SMBTJgWLj4lYkXMoFz")
    expect(@teacher.first_name).to eq("Boom")
    expect(@teacher.last_name).to eq("Shakalaka")
    expect(@teacher.school_name).to eq(nil)
    expect(@teacher.school_district).to eq(nil)
  end
end

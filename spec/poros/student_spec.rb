require 'rails_helper'

describe Student do
  before :each do
    @student_info = {:id=>"1",
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

    @student = Student.new(@student_info)
  end

  it "exists with attributes" do
    expect(@student).to be_a(Student)
    expect(@student.id).to eq(1)
    expect(@student.provider).to eq("google_oauth2")
    expect(@student.uid).to eq("1057629160")
    expect(@student.email).to eq("boom@email.com")
    expect(@student.token).to eq("ya29.A0AfH6SMBTJgWLj4lYkXMoFz")
    expect(@student.first_name).to eq("Boom")
    expect(@student.last_name).to eq("Shakalaka")
  end
end

require 'rails_helper'

# RSpec.describe Page, :type => :model do
RSpec.describe 'links' do
  describe "test all links" do
    it "works! (now write some real specs)" do
      # binding.pry
      Pages::MenuPresenter.new( menu_items, self).collection.each do |mi|
        # binding.pry
        path = get_path mi
        path.match(/(.*)\?/)
        visit $1
        p (get_path mi)
        expect(page).to have_http_status(:success) 
      end

    end
          end
          end

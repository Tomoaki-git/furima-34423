require 'rails_helper'
# describe ItemsController, type: :request do

#   before do
#     @item = FactoryBot.build(:item)
#     @item.image = fixture_file_upload('public/images/test_image.jpg')
#     @item.save
#   end

#   describe 'GET #index' do
#     it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
#       get root_path
#       expect(response.status).to eq 200
#     end
#     it 'indexアクションにリクエストするとレスポンスに投稿済みの商品名(item_name)が存在する' do 
#       get root_path
#       expect(response.body).to include(@item.item_name)
#     end
#     it 'indexアクションにリクエストするとレスポンスに投稿済み商品の画像URLが存在する' do 
#       get root_path
#       expect(response.body).to include(@item.image)
#     end
#     it 'indexアクションにリクエストするとレスポンスに投稿済み商品の金額(price)が存在する' do 
#       get root_path
#       expect(response.body).to include(@item.price)
#     end
#     it 'indexアクションにリクエストするとレスポンスに商品投稿フォームが存在する' do 
#       get root_path
#       expect(response.body).to include('出品する')
#     end
#   end
# end
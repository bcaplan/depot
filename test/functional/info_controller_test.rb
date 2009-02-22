require 'test_helper'

class InfoControllerTest < ActionController::TestCase
  test "info gets xml" do
    get :who_bought, :id => products(:one).id, :format => 'xml'
    
    assert_response :success
    assert_tag :tag => 'title', :content => products(:one).title
  end
  
  test "info gets atom" do
    get :who_bought, :id => products(:one).id, :format => 'atom'
    
    assert_response :success
    assert_tag :tag => 'title', :content => "Who bought #{products(:one).title}"
  end
  
  test "info gets json" do
    get :who_bought, :id => products(:one).id, :format => 'json'
    
    assert_response :success
    doc = ActiveSupport::JSON.decode(@response.body)
    
    assert_equal doc['product']['title'], products(:one).title
  end
  
  test "info gets html" do
    get :who_bought, :id => products(:one).id
    
    assert_response :success
    assert_tag :tag => 'div', :attributes => { :id => 'main' },
               :descendant => { :tag => 'h3', :content => "People Who Bought #{products(:one).title}" }
  end
end

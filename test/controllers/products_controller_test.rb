require 'test_helper'

class
 ProductControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path

        assert_response :success
        assert_select '.product', 2
    end

    test 'render detailed product page' do
        get product_path(products(:Xaiomi))

        assert_response :success
        assert_select '.title', 'Celular Xaiomi'
        assert_select '.description', 'Celular en caja nuevo del año 2019'
        assert_select '.price', '$ 95'
    end

    test 'render a new product form' do
        get new_product_path

        assert_response :success
        assert_select 'form'
    end

    test 'allow to create a new product' do
        post products_path, params: {
            product:{
                title: 'Nintendo 64',
                description: 'Le faltan los cables',
                price: 55
            }
        }

        assert_redirected_to products_path
    end

    test 'does not allow to create a new product with empty fields' do
        post products_path, params: {
            product:{
                title: '',
                description: 'Le faltan los cables',
                price: 55
            }
        }

        assert_response :unprocessable_entity
    end

end
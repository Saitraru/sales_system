require 'test_helper'

class
 ProductControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path

        assert_response :success
        assert_select '.product', 3
        assert_select '.category', 4
    end

    test 'render a list of products filtered by category' do
        get products_path(category_id: categories(:computers).id)

        assert_response :success
        assert_select '.product', 1
    end

    test 'render a list of products filtered by mi_price and max_price' do
        get products_path(min_price: 300, max_price: 310)

        assert_response :success
        assert_select '.product', 1
        assert_select 'h2', 'Nintendo switch'
    end

    test 'search a product by query_text' do
        get products_path(query_text: 'Switch')

        assert_response :success
        assert_select '.product', 1
        assert_select 'h2', 'Nintendo switch'
    end

    test 'sort products by expensive prices first' do
        get products_path(order_by: 'expensive')

        assert_response :success
        assert_select '.product', 3
        assert_select '.products .product:first-child h2', 'Nintendo switch'
    end

    test 'sort products by cheapest prices first' do
        get products_path(order_by: 'cheapest')

        assert_response :success
        assert_select '.product', 3
        assert_select '.products .product:first-child h2', 'Celular Xaiomi'
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
                price: 55,
                category_id: categories(:videogames).id
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se creó correctamente'
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

    test 'render an edit product form' do
        get edit_product_path(products(:Switch))

        assert_response :success
        assert_select 'form'
    end

    test 'allow to update a product' do
        patch product_path(products(:Switch)), params: {
            product:{
                price: 300
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se actualizó correctamente'
    end

    test 'does not allow to update a product' do
        patch product_path(products(:Switch)), params: {
            product:{
                price: nil
            }
        }

        assert_response :unprocessable_entity
    end

    test 'can delete products' do
        assert_difference('Product.count', -1) do
            delete product_path(products(:Xaiomi))
        end

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se eliminó correctamente'
    end

end
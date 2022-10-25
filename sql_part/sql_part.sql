#First
SELECT product_name,
       product_img_url,
       product_url,
       product_price_min,
       product_short_description
FROM grommet_products
WHERE id IN
    (SELECT product_id
    FROM grommet_product_categories
    WHERE grommet_product_categories.product_category_id = (
        SELECT grommet_gifts_categories.id
        FROM grommet_gifts_categories
        INNER JOIN grommet_product_categories
        ON grommet_gifts_categories.id = grommet_product_categories.product_category_id
        WHERE sub_category = 'Jewelry'
        LIMIT 1
        )
    )
AND grommet_products.is_sold_out = 0;

#Second
SELECT product_name,
       product_img_url,
       product_url,
       product_price_min,
       product_short_description
FROM grommet_products
WHERE id IN
    (SELECT product_id
    FROM grommet_product_to_keyword
    WHERE grommet_product_to_keyword.keyword_id = (
        SELECT grommet_product_keywords.id
        FROM grommet_product_keywords
        INNER JOIN grommet_product_to_keyword
        ON grommet_product_keywords.id = grommet_product_to_keyword.keyword_id
        WHERE keyword = 'Hair accessor'
        LIMIT 1
        ))
AND grommet_products.is_sold_out = 0;


#Third
SET @keyword_id = (
    SELECT grommet_product_keywords.id
    FROM grommet_product_keywords
    INNER JOIN grommet_product_to_keyword
    ON grommet_product_keywords.id = grommet_product_to_keyword.id
    WHERE keyword = 'Aromatherapy'
    );

SELECT product_name,
       product_img_url,
       product_url,
       product_price_min,
       product_short_description
FROM grommet_products
WHERE id
IN  (SELECT product_id
    FROM grommet_product_to_keyword
    WHERE grommet_product_to_keyword.keyword_id = @keyword_id)
OR id IN (
    SELECT grommet_gifts_categories.id
    FROM grommet_gifts_categories
    INNER JOIN grommet_product_categories
    ON grommet_gifts_categories.id = grommet_product_categories.product_category_id
    WHERE sub_category = 'Beauty & Personal Care'
    OR sub_category = 'Skincare'
    )
AND grommet_products.is_sold_out = 0;
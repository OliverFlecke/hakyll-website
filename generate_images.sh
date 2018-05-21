for entry in "images"/*.pdf
do
    convert -density 300 -quality 90 -negate "$entry" "${entry%.*}".png
    rm "${entry%.*}".pdf
done
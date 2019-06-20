pylinkvalidate.py \
	    --progress \
	    --timeout=35 \
	    --depth=2 \
	    --workers=10 \
	    --types=a \
	    --strict \
	    --test-outside \
	    --parser=lxml \
	    --header="User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; FSL 7.0.6.01001)" \
        -E all \
        -o check-links.log \
	    http://0.0.0.0:8000/

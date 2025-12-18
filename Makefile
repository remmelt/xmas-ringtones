.PHONY: convert build wav2m4a

wav2m4a:
	@for f in in/*.wav; do \
		[ -f "$$f" ] || continue; \
		out="$${f%.wav}.m4a"; \
		echo "Converting $$f -> $$out"; \
		ffmpeg -i "$$f" -c:a aac -b:a 128k "$$out" -y; \
		rm -v "$$f"; \
	done

convert:
	rm -rf out
	mkdir out
	fd . in -x ./go.sh

build: convert
	./generate-html.sh

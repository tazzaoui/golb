BLOG_DIR=html

all: clean rss docs index

index:
	$(shell pandoc index.md -o index-temp.html)
	$(shell cat utils/header-index index-temp.html utils/footer-index > index.html)
	$(shell cat utils/footer-rss >> html/rss.xml)
	mv index.html $(BLOG_DIR)
	rm -f index-temp.html

upload:
	scp html/rss.xml taha@tahaazzaoui.com:/var/www/html
	scp -r $(BLOG_DIR)/*.html taha@tahaazzaoui.com:/var/www/html/blog

rss:
	$(shell cat utils/header-rss > html/rss.xml)

clean:
	rm -f index.md html/*.html

docs: setting_up_tor_on_arch_linux the_cloud_is_someone_elses_computer a_blogging_system_in_less_than_100_lines_of_code matrix_multiply indexer snells_law rc_circuits_odes uniform_magnetic_fields electric_forces_and_fields web_crawler search_engine integral_roots runga_kutta euler_ode gradient_descent binary_bomb_4 binary_bomb_3 binary_bomb_2 binary_bomb_1 binary_bomb_0 


setting_up_tor_on_arch_linux: src/setting_up_tor_on_arch_linux.md
	./md2html.sh setting_up_tor_on_arch_linux.md
	mv setting_up_tor_on_arch_linux.html $(BLOG_DIR)

the_cloud_is_someone_elses_computer: src/the_cloud_is_someone_elses_computer.md
	./md2html.sh the_cloud_is_someone_elses_computer.md
	mv the_cloud_is_someone_elses_computer.html $(BLOG_DIR)

a_blogging_system_in_less_than_100_lines_of_code: src/a_blogging_system_in_less_than_100_lines_of_code.md
	./md2html.sh a_blogging_system_in_less_than_100_lines_of_code.md
	mv a_blogging_system_in_less_than_100_lines_of_code.html $(BLOG_DIR)

matrix_multiply: src/matrix_multiply.md
	./md2html.sh matrix_multiply.md
	mv matrix_multiply.html $(BLOG_DIR)

indexer: src/indexer.md
	./md2html.sh indexer.md
	mv indexer.html $(BLOG_DIR)

snells_law: src/snells_law.md
	./md2html.sh snells_law.md
	mv snells_law.html $(BLOG_DIR)

rc_circuits_odes: src/rc_circuits_odes.md
	./md2html.sh rc_circuits_odes.md
	mv rc_circuits_odes.html $(BLOG_DIR)

uniform_magnetic_fields: src/uniform_magnetic_fields.md
	./md2html.sh uniform_magnetic_fields.md
	mv uniform_magnetic_fields.html $(BLOG_DIR)

electric_forces_and_fields: src/electric_forces_and_fields.md
	./md2html.sh electric_forces_and_fields.md
	mv electric_forces_and_fields.html $(BLOG_DIR)

web_crawler: src/web_crawler.md
	./md2html.sh web_crawler.md
	mv web_crawler.html $(BLOG_DIR)

search_engine: src/search_engine.md
	./md2html.sh search_engine.md
	mv search_engine.html $(BLOG_DIR)

integral_roots: src/integral_roots.md
	./md2html.sh integral_roots.md
	mv integral_roots.html $(BLOG_DIR)

runga_kutta: src/runga_kutta.md
	./md2html.sh runga_kutta.md
	mv runga_kutta.html $(BLOG_DIR)

euler_ode: src/euler_ode.md
	./md2html.sh euler_ode.md
	mv euler_ode.html $(BLOG_DIR)

gradient_descent: src/gradient_descent.md
	./md2html.sh gradient_descent.md
	mv gradient_descent.html $(BLOG_DIR)

binary_bomb_4: src/binary_bomb_4.md
	./md2html.sh binary_bomb_4.md
	mv binary_bomb_4.html $(BLOG_DIR)

binary_bomb_3: src/binary_bomb_3.md
	./md2html.sh binary_bomb_3.md
	mv binary_bomb_3.html $(BLOG_DIR)

binary_bomb_2: src/binary_bomb_2.md
	./md2html.sh binary_bomb_2.md
	mv binary_bomb_2.html $(BLOG_DIR)

binary_bomb_1: src/binary_bomb_1.md
	./md2html.sh binary_bomb_1.md
	mv binary_bomb_1.html $(BLOG_DIR)

binary_bomb_0: src/binary_bomb_0.md
	./md2html.sh binary_bomb_0.md
	mv binary_bomb_0.html $(BLOG_DIR)


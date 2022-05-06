# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

post_atrributes = []
10.times do |i|
  post_atrributes << { title: "Sample Title #{i}", body: "Sample body #{i}" }
end

Snowflake::Connection.instance.run("""
  create or replace table posts (
    id integer,
    title string,
    body string
  );
""")

Snowflake::Connection.instance.run("""
  create or replace table comments (
    id integer,
    body string,
    post_id integer
  );
""")

post_atrributes.each do |attributes|
  post = Post.where(attributes).first_or_create
  Snowflake::Connection.instance.run("""
    insert into posts (id, title, body) values (#{post.id}, 'Snowflake - #{post.title}', '#{post.body}');
  """);
end

Post.all.each do |post|
  3.times do |i|
    comment = post.comments.where(body: "#{post.title} - comment #{i}").first_or_create
    Snowflake::Connection.instance.run("""
      insert into comments (id, body, post_id) values (#{comment.id}, 'Snowflake - #{comment.body}', #{comment.post_id});
    """);
  end
end

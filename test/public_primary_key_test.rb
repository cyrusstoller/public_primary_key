require 'test_helper'
require_relative 'models/post'

class PublicPrimaryKeyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil PublicPrimaryKey::VERSION
  end

  def test_post_model_responds_to_public_primary_key
    assert_respond_to Post, :public_primary_key
    refute_respond_to Post.new, :public_primary_key
  end

  def test_on_create_post_has_a_uuid
    post = Post.create
    refute_nil post.uuid
    assert post.uuid.length, Post::STRING_LENGTH
  end

  def test_post_responds_with_uuid_for_to_param
    post = Post.create
    assert_equal post.to_param, post.uuid
  end

  def test_disallow_saving_without_a_public_primary_key
    post = Post.create
    post.uuid = ""
    refute post.valid?
  end

  def test_disallow_whitespace_in_the_public_primary_key
    post = Post.create
    post.uuid = "hd 3"
    refute post.valid?
  end

  def test_that_the_uuid_is_unique
    post1 = Post.create
    post2 = Post.create
    post2.uuid = post1.uuid
    refute post2.valid?
  end
end

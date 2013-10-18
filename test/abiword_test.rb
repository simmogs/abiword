require 'test/unit'
require File.join(File.dirname(File.dirname(__FILE__)),"lib/abiword")

class AbiwordTest < Test::Unit::TestCase

  TEST_FILES = ['testfiles/testfile.pdf', 'testfiles/testfile.odt']

  def cleanup
    TEST_FILES.each do |file|
      File.delete(file) if File.exists?(file)
    end
  end

  def teardown
    TEST_FILES.each do |file|
      File.delete(file) if File.exists?(file)
    end
  end

  def test_success_doc
    Abiword::Abiword.doc2pdf("testfiles/testfile.doc")
    assert File.exists?("testfiles/testfile.pdf")
  end

  def test_success_odt
    Abiword::Abiword.doc2odt("testfiles/testfile.doc")
    assert File.exists?("testfiles/testfile.odt")
  end

  def test_failure_missing_file
    assert_raises Exceptions::AbiwordException do
      Abiword::Abiword.doc2pdf("testfiles/nonexistent.doc")
    end
    assert !File.exists?('testfiles/nonexistent.pdf')
  end

end

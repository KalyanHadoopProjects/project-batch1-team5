package com.spark.scala.examples

import org.apache.spark.sql.Row
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.types._

object CreatingRDDsDFsDS {
  case class Person(name: String, age: Long)

  def main(args: Array[String]) {

    // Creating spark session variable
    val spark = SparkSession
      .builder()
      .appName("Creating RDDs, DataFrames and DataSets")
      .config("spark.some.config.option", "some-value")
      .getOrCreate()

    // Import statements for RDDs to Data Frames
    import spark.implicits._
    
    runBasicDataExample(spark)
    runDatasetCreationExample(spark)

    // Stopping spark session variable
    spark.stop()

  }
  
  // Creating Data Frame from a JSON file
  private def runBasicDataExample(spark: SparkSession): Unit = {
    
    // Reading JSON File and creating DF
    val dataFrame = spark.read.json("/home/orienit/people.json")
    
    // Displaying Data Frame
    dataFrame.show()
    
    // This import is needed to use the $-notation
    import spark.implicits._
    
    // Displaying schema in a tree format
    dataFrame.printSchema()
    
    // Some select statements on dataFrame
    dataFrame.select("name").show()
    dataFrame.select($"age" > 21)
    
    // Count people by age
    dataFrame.groupBy("age").count().show()
    
    // Registering the dataFrame as an SQL temporary view
    dataFrame.createOrReplaceTempView("people")
    
    // println("Creating temporary view for SQL")
    // SQL query on the temporary view
    val sqlDF = spark.sql("SELECT * FROM people")
    sqlDF.show()
    
    // Global temporary view is tied to a system preserved database 'global_temp'
    dataFrame.createGlobalTempView("people")
    
    spark.sql("SELECT * FROM global_temp.people").show()
    
    // Global temporary view is cross-session
    spark.newSession().sql("SELECT * FROM global_temp.people").show()
    
  }
  
  private def runDatasetCreationExample(spark: SparkSession): Unit = {
    // Import statement for implicit conversion
    import spark.implicits._
    
    // Encoders are created for case classes
    val caseClassDF = Seq(Person("Andy", 32)).toDS()
    
    // Displaying Data set
    caseClassDF.show()
    
    // Encoders for most common types are automatically provided by importing spark.implicits._
    val primitiveDS = Seq(1,2,3).toDS()
    
    //Displaying the primitive data set
    primitiveDS.map ( _ +1 ).collect()
    println("----------------------------")
    
    // Data Frames can be converted to a Dataset by providing a class. Mapping will done by name.
    val path = "/home/orienit/people.json"
    val peopleDS = spark.read.json(path).as[Person]
    peopleDS.show()
    
    
    
  }
  
  
  
  

}
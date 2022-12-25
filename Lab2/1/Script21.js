cls
use mydb
db
show dbs
db.movie.insert({"name":"tutorials point"})
show dbs
db.dropDatabase()
show dbs
db.createCollection("mycollection")
show collections
db.createCollection("mycol", {capped:true, autoIndexID : true, size : 6142800, max : 10000})
db.tutorialspoint.insert({"name" : "tutorialspoint"})
show collections
db.mycollection.drop()
show collections
db.users.insert({
    _id : ObjectId("507f191e810c19729de860ea"),
    title : "MongoDB Overview",
    description : "MongoDB is no sql database",
    by : "tutorials point",
    url : "http://www.tutorialspoint.com",
    tags: ["mongoDB", "database", "NoSQL"],
    likes: 100
})
db.post.insert([
{
    title : "MongoDB Overview",
    description : "MongoDB is no sql database",
    by : "tutorials point",
    url : "http://www.tutorialspoint.com",
    tags: ["mongoDB", "database", "NoSQL"],
    likes: 100
},
{
    title : "NoSQL Database",
    description : "NoSQL database doesn't have tables",
    by : "tutorials point",
    url : "http://www.tutorialspoint.com",
    tags: ["mongoDB", "database", "NoSQL"],
    likes: 20,
    comments:[
    {
        user:"user1",
        message:"My first comment",
        dataCreated: new Date(2013,11,10,2,35),
        like: 0
    }
    ]
}
])
db.createCollection("empDetails")
db.empDetails.insertOne(
{
    First_Name: "Radhika",
    Last_Name: "Sharma",
    Date_Of_Birth: "1995-09-26",
    e_mail: "radhika_sharma.123@gmail.com",
    phone: "9848022338"
})
db.empDetails.insertMany(
    [
        {
            First_Name: "Radhika",
            Last_Name: "Sharma",
            Date_Of_Birth: "1995-09-26",
            e_mail: "radhika_sharma.123@gmail.com",
            phone: "9000012345"
        },
        {
            First_Name: "Rachel",
            Last_Name: "Christopher",
            Date_Of_Birth: "1990-02-16",
            e_mail: "Rachel_Christopher.123@gmail.com",
            phone: "9000054321"
        },
        {
            First_Name: "Fathima",
            Last_Name: "Sheik",
            Date_Of_Birth: "1990-02-16",
            e_mail: "Fathima_Sheik.123@gamil.com",
            phone: "9000054321"
        }
    ]
)
db.createCollection("mycol")
db.mycol.insert([
{
    title : "MongoDB Overview",
    description : "MongoDB is no sql database",
    by : "tutorials point",
    url : "http://www.tutorialspoint.com",
    tags: ["mongoDB", "database", "NoSQL"],
    likes: 100
},
{
    title : "NoSQL Database",
    description : "NoSQL database doesn't have tables",
    by : "tutorials point",
    url : "http://www.tutorialspoint.com",
    tags: ["mongoDB", "database", "NoSQL"],
    likes: 20,
    comments:[
    {
        user:"user1",
        message:"My first comment",
        dataCreated: new Date(2013,11,10,2,35),
        like: 0
    }
    ]
}
])
db.mycol.find()
db.mycol.find().pretty()
db.mycol.findOne({title: "MongoDB Overview"})
db.mycol.find({$and:[{"by":"tutorials point"},{"title":"MongoDB Overview"}]}).pretty()
db.mycol.find({$or: [{"by":"tutorials point"},{"title":"MongoDB Overview"}]}).pretty()
db.mycol.find({"likes":{$gt:10}, $or:[{"by":"tutorials point"}, {"title": "MogoDB Overview"}]}).pretty()
db.empDetails.find({$nor:[{First_Name:"Radhika"},{Last_Name:"Christopher"}]}).pretty()
db.empDetails.find({"Age":{$not:{$gt:"25"}}})
db.mycol.update({"title":"MongoDB Overview"},{$set:{"title":"New MongoDB Tutorial"}})
db.mycol.find()
db.mycol.update({"title":"MongoDB Overview"},{$set:{"title":"New MongoDB Tutorial"}},{multi:true})
show dbs
show collections


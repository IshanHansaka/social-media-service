import ballerina/http;

table<Post> key(id) postsTable = table [
    {
        id: 1,
        userId: 1,
        description: "Exploring Ballerina Language",
        tags: "ballerina, programming, language",
        category: "Technology"
    },
    {
        id: 2,
        userId: 2,
        description: "Introduction to Microservices",
        tags: "microservices, architecture, introduction",
        category: "Software Engineering"
    }
];

service /api on new http:Listener(9090) {

    resource function get posts(string? category) returns Post[] {
        if category is string && category != "" {
            // Filter posts based on the category
            return from Post post in postsTable
                   where post.category == category
                   select post;
        } else {
            // Return all posts if category is not provided or category is Nil
            return postsTable.toArray();
        }
    }
}

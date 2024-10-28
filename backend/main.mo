import Bool "mo:base/Bool";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

import Array "mo:base/Array";
import Time "mo:base/Time";
import Option "mo:base/Option";

actor {
  type Post = {
    id: Nat;
    title: Text;
    body: Text;
    author: Text;
    timestamp: Int;
  };

  stable var posts : [Post] = [];
  stable var nextId : Nat = 0;

  public func createPost(title: Text, body: Text, author: Text) : async Nat {
    let post : Post = {
      id = nextId;
      title = title;
      body = body;
      author = author;
      timestamp = Time.now();
    };
    posts := Array.append(posts, [post]);
    nextId += 1;
    nextId - 1
  };

  public query func getPosts() : async [Post] {
    Array.reverse(posts)
  };

  public query func getPost(id: Nat) : async ?Post {
    Array.find(posts, func (post: Post) : Bool { post.id == id })
  };
}

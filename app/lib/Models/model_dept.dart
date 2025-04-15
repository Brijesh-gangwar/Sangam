class Departments {
    String id;
    String name;
    String description;
    int v;

    Departments({
        required this.id,
        required this.name,
        required this.description,
        required this.v,
    });

    factory Departments.fromJson(Map<String, dynamic> json) {return Departments(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        v: json["__v"],
    );}

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "__v": v,
    };
}

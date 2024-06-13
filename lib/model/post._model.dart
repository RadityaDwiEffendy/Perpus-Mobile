class Post {
  final int id;
  final String author;
  final String judul;
  final String image_url;
  final String deskripsi;
  final String paragraf1;
  final String paragraf2;
  final String paragraf3;
  final String paragraf4;

  Post({
    required this.id,
    required this.author,
    required this.judul,
    required this.image_url,
    required this.deskripsi,
    required this.paragraf1,
    required this.paragraf2,
    required this.paragraf3,
    required this.paragraf4,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      author: json['author'],
      judul: json['judul'],
      image_url: json['image_url'],
      deskripsi: json['deskripsi'],
      paragraf1: json['paragraf1'],
      paragraf2: json['paragraf2'],
      paragraf3: json['paragraf3'],
      paragraf4: json['paragraf4'],
    );
  }
}


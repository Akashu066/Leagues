
# Leauges Using Flutter

It's an music album application in which user will get albums list on home screen. User can also search for any ablum. There is music list for the particulr ablum on detail screen.


## API Reference

#### Get album list

```http
  GET https://jsonplaceholder.typicode.com/albums
```

#### Get album's music list

```http
  GET https://jsonplaceholder.typicode.com/albums/{id}/photos
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch music list |

#### Get search ablums

```http
  GET https://jsonplaceholder.typicode.com/albums?title=
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `title=`      | `string` | **Required**. title of album to search |

## Tech Stack

**Platform:** VS Code

**Framework:** Flutter 3

**Programming Language:** Dart

**Architecture:** BLoC


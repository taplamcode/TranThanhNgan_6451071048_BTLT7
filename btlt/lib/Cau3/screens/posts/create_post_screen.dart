import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';
import '../../data/repository/post_repository.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PostRepository repository = PostRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController userIdController = TextEditingController(
    text: '1',
  );

  bool isLoading = false;
  String responseText = '';

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    userIdController.dispose();
    super.dispose();
  }

  Future<void> submitPost() async {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();
    final userId = int.tryParse(userIdController.text.trim()) ?? 1;

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui long nhap day du tieu de va noi dung'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
      responseText = '';
    });

    try {
      final post = PostModel(title: title, body: body, userId: userId);
      final created = await repository.createPost(post);

      final prettyResponse =
          'id: ${created.id}\nuserId: ${created.userId}\ntitle: ${created.title}\nbody: ${created.body}';

      if (!mounted) {
        return;
      }

      setState(() {
        responseText = prettyResponse;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully')),
      );

      debugPrint('POST response: $prettyResponse');
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        responseText = 'Error: $e';
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tao post that bai: $e')));
    } finally {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: userIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : submitPost,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create Post'),
            ),
            const SizedBox(height: 20),
            if (responseText.isNotEmpty)
              SelectableText(
                responseText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';

class Generate extends StatefulWidget {
  const Generate({super.key});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final TextEditingController _promptController = TextEditingController();
  bool _isGenerating = false;
  final List<String> _generatedImages = []; // store generated image URLs/paths

  Future<void> _onGenerate() async {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;

    setState(() => _isGenerating = true);

    // Simulate API delay + image result
    await Future.delayed(const Duration(seconds: 2));

    // You’d replace this with your image generation API result (URL/path)
    setState(() {
      _generatedImages.insert(
        0,
        'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/400/300',
      );
      _isGenerating = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = GoRouterState.of(context);
    final prompt = state.extra as Prompt;
    _promptController.text = prompt.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Imagines Generator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 30),
            children: [
              const SizedBox(height: 20),

              /// Prompt Input Field (Large TextArea)
              TextField(
                controller: _promptController,
                minLines: 4,
                maxLines: 8,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your prompt or paste saved one...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,

                  fillColor: const Color(0xff1e1e1e),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        color: Color.fromARGB(255, 29, 32, 32),
                      ),
                      label: const Text(
                        'Attach File',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color.fromARGB(255, 50, 56, 55),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 17, 18, 18),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isGenerating ? null : _onGenerate,
                      icon: _isGenerating
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : const Icon(Icons.auto_awesome, color: Colors.black),
                      label: Text(
                        _isGenerating ? 'Generating...' : 'Generate',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Generated Images Section
              if (_generatedImages.isEmpty && !_isGenerating)
                const Center(
                  child: Text(
                    'Generated images will appear here...',
                    style: TextStyle(color: Colors.white38),
                  ),
                ),

              if (_isGenerating && _generatedImages.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(color: Colors.tealAccent),
                  ),
                ),

              // Show generated images
              ..._generatedImages.map(
                (imgUrl) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          color: const Color(0xff1a1a1a),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.tealAccent,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}

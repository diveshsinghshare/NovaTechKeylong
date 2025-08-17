import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:novatech/screens/on_boarding_screens/Image_verification_screen.dart';
import 'package:permission_handler/permission_handler.dart';

enum PromptState { selectPrompt, promptSelected, recording, recorded }

class VoicePromptScreen extends StatefulWidget {
  const VoicePromptScreen({super.key});

  @override
  State<VoicePromptScreen> createState() => _VoicePromptScreenState();
}

class _VoicePromptScreenState extends State<VoicePromptScreen> {
  PromptState _state = PromptState.selectPrompt;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  String? _filePath;
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  bool _isPlaying = false;

  final Duration _maxDuration = const Duration(seconds: 30);

  final List<String> prompts = [
    "A topic I could talk about for hours",
    "The book/show that changed how I think",
    "My favorite childhood memory"
  ];
  String? _selectedPrompt;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> _startRecording() async {
    final hasMic = await Permission.microphone.isGranted;
    if (!hasMic) return;

    final path =
        "/storage/emulated/0/Download/voice_prompt_${DateTime.now().millisecondsSinceEpoch}.aac";

    await _recorder.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );

    setState(() {
      _state = PromptState.recording;
      _filePath = path;
      _elapsed = Duration.zero;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_recorder.isRecording) {
        _stopRecording();
        return;
      }
      setState(() {
        _elapsed = Duration(seconds: _elapsed.inSeconds + 1);
      });
      if (_elapsed >= _maxDuration) {
        _stopRecording();
      }
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _recorder.stopRecorder();
    setState(() {
      _state = PromptState.recorded;
    });
  }

  void _resetRecording() {
    setState(() {
      _filePath = null;
      _elapsed = Duration.zero;
      _state = PromptState.promptSelected;
    });
  }

  Future<void> _togglePlayback() async {
    if (_filePath == null) return;

    if (_isPlaying) {
      await _player.stopPlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
        fromURI: _filePath,
        codec: Codec.aacADTS,
        whenFinished: () {
          setState(() => _isPlaying = false);
        },
      );
      setState(() => _isPlaying = true);
    }
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString();
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Skip"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 0.3,
              color: Colors.purple,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            const Text(
              "Let your voice prompt spark a connection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("This voice prompt unlocks after you both vibe",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            if (_state == PromptState.selectPrompt) ...[
              DropdownButton<String>(
                hint: const Text("Select your prompt"),
                value: _selectedPrompt,
                isExpanded: true, // ✅ Makes dropdown take full width and wrap text
                items: prompts
                    .map(
                      (p) =>
                          DropdownMenuItem(
                    value: p,
                    child: Text(
                      p,
                      overflow: TextOverflow.visible, // ✅ Prevent overflow
                      softWrap: true,
                      maxLines: 4,       // ✅ no limit on lines
                    ),
                  ),
                )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedPrompt = val;
                    _state = PromptState.promptSelected;
                  });
                },
              ),
            ]
            else ...[
              Text(_selectedPrompt ?? "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],

            const SizedBox(height: 20),

            if (_state == PromptState.promptSelected) ...[
              Text("${_formatDuration(_elapsed)} / 0:30"),
              const SizedBox(height: 20),
              IconButton(
                iconSize: 60,
                color: Colors.purple,
                icon: const Icon(Icons.mic),
                onPressed: _startRecording,
              ),
              const Text("Tap to record something"),
            ] else if (_state == PromptState.recording) ...[
              Text("Recording... ${_formatDuration(_elapsed)} / 0:30"),
              const SizedBox(height: 20),
              IconButton(
                iconSize: 60,
                color: Colors.red,
                icon: const Icon(Icons.stop),
                onPressed: _stopRecording,
              ),
            ] else if (_state == PromptState.recorded) ...[
              Text("Recorded ${_formatDuration(_elapsed)} sec"),
              const SizedBox(height: 20),
              IconButton(
                iconSize: 60,
                color: Colors.purple,
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                onPressed: _togglePlayback,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: _resetRecording,
                icon: const Icon(Icons.refresh),
                label: const Text("Redo recording"),
              )
            ],

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: _state == PromptState.recorded
                    ? Colors.purple
                    : Colors.grey,
              ),
              onPressed: _state == PromptState.recorded
                  ? () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageVerificationScreen()),
                  )
                  : null,
              child: const Text("Continue",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}

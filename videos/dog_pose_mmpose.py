from mmpose.apis import MMPoseInferencer
import argparse
import json

def detect_pose(input_path, output_dir='outputs'):
    """Detect dog pose in image or video."""
    inferencer = MMPoseInferencer('animal')
    results = inferencer(input_path, show=False, out_dir=output_dir, return_vis=True)
    
    for result in results:
        predictions = result['predictions']
        print(predictions)
        # for pred in predictions:
        #     keypoints = pred['keypoints']
        #     scores = pred['keypoint_scores']
        #     print(f"\nDetected keypoints:")
        #     for i, (kpt, score) in enumerate(zip(keypoints, scores)):
        #         print(f"Point {i}: x={kpt[0]:.2f}, y={kpt[1]:.2f}, confidence={score:.3f}")
    
    print(f'\nResults saved to {output_dir}')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Dog pose detection with MMPose')
    parser.add_argument('--input', type=str, required=True, help='Path to image or video')
    parser.add_argument('--output', type=str, default='outputs', help='Output directory')
    
    args = parser.parse_args()
    detect_pose(args.input, args.output)

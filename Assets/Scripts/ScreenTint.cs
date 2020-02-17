
// Attach me to a gameobject in the scene such as the main camera
using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class ScreenTint : MonoBehaviour {

	[Range(0,1)]
	public float intensity;
    public Color color;
	private Material material;

	// Creates a private material used to the effect
	void Awake ()
	{
		material = new Material( Shader.Find("Custom/ScreenEffects/ScreenTint") );
	}
	
	// Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		if (intensity == 0)
		{
			Graphics.Blit (source, destination);
			return;
		}

        material.SetColor("_Color", color);
		material.SetFloat("_Intensity", intensity);
		Graphics.Blit (source, destination, material);
	}
}
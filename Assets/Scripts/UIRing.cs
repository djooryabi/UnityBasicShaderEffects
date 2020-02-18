// Attach me to a gameobject in the scene such as the main camera
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIRing : MonoBehaviour
{
    [Range(-2,2)]
    public float xPosition;
    [Range(-2,2)]
    public float yPosition;
    [Range(0,1)]
    public float radius;
    [Range(0,1)]
    public float ringThickness;
    public Color color;
    private Material material;

    // Creates a private material used to the effect
	void Awake ()
	{
		material = new Material(Shader.Find("Custom/ScreenEffects/UIRing") );
        float aspect = ((float)Mathf.Max(Screen.width, Screen.height)) / Mathf.Min(Screen.width, Screen.height);
        
        if(Screen.width > Screen.height) {
            material.SetFloat("_XScale", aspect);
            material.SetFloat("_YScale", 1.0f);
        } else {
            material.SetFloat("_XScale", 1.0f);
            material.SetFloat("_YScale", aspect);
        }
        
        material.SetFloat("_AspectRatio", aspect);
	}

    // Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
        material.SetFloat("_XPosition", xPosition);
        material.SetFloat("_YPosition", yPosition);
        material.SetFloat("_Radius", radius);
        material.SetFloat("_RingThickness", ringThickness);
        material.SetColor("_Color", color);
		Graphics.Blit (source, destination, material);
	}
}
